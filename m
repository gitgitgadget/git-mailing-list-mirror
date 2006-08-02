From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: git-push and -f option
Date: Wed, 2 Aug 2006 14:03:12 +0530
Message-ID: <cc723f590608020133o3c960cf0v1546c59319253dc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 02 10:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8CAG-0007KG-QM
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 10:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWHBIdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 04:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWHBIdO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 04:33:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:46981 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751365AbWHBIdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 04:33:13 -0400
Received: by nf-out-0910.google.com with SMTP id o25so561741nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 01:33:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iVbd1Ntkr4QinNcZYHojfO3EzMzZ7ywa9dqJ1QqiN/PzEZAhL/TrLLOwdsCdE9r4BuiF06atcrhKlyIP7n9sXOSwFzvGvkLNlN5gnLPW9aKx6nG+93DhrGpzPD/eX8Sh+vaKx0IU9vYtpBw0keU6Ly3EwOVCcdrChbmsf9kgAZg=
Received: by 10.49.10.3 with SMTP id n3mr1922426nfi;
        Wed, 02 Aug 2006 01:33:12 -0700 (PDT)
Received: by 10.49.57.11 with HTTP; Wed, 2 Aug 2006 01:33:12 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24639>

The man page says -f is same as --force.  But the script doesn't seems
to handle this.

-aneesh

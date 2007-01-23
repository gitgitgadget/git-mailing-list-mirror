From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: public git repo with shallow clone support
Date: Tue, 23 Jan 2007 13:00:57 +0530
Message-ID: <cc723f590701222330y54d5b784k149d63349ce14574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 23 08:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9G7U-0001ka-QJ
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 08:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbXAWHbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 02:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbXAWHbA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 02:31:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:60889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbXAWHa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 02:30:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so144610nfa
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 23:30:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IP+dwCRBRyNaXtn+Jz7+uEqJEOM0NaRNKVTcZMx8sgdzL/k4Cv1wyGLSp2DtYaQ9r02GDVB7jcXZXikqEN2R/BEMzbkQxVzqppKM0DzQvq3OPjARQvOAy82P3wleZPLPcb5s6rZc7RiZWtaSdbyEyZj/IYseeKNpIe0IJdslHMQ=
Received: by 10.49.29.2 with SMTP id g2mr614046nfj.1169537458059;
        Mon, 22 Jan 2007 23:30:58 -0800 (PST)
Received: by 10.48.212.18 with HTTP; Mon, 22 Jan 2007 23:30:56 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37485>

Hi All,

I want to clone linux kernel repository using --depth ( shallow
clone). Is there a plublic repository out there that support shallow
clone ?

-aneesh

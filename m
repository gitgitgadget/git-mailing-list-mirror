From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Redhat stateless Linux and git
Date: Fri, 9 Jun 2006 18:59:44 -0400
Message-ID: <9e4733910606091559m6a88e864m16f9d75a507ee684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 10 00:59:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FopxE-0003PJ-B5
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 00:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWFIW7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWFIW7p
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 18:59:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:38150 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030274AbWFIW7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 18:59:44 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1207168nze
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 15:59:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fr8zSEXISPyzpUrH2lF8IIFxgQ0kKeUhWOtjsVQyro7nrzpepZPz7IbOyrK1thcsuHEcZeC2OniSRpEFAs75Gqhiaa9KoLD8R5a4AaufYuxQk1MSJkEt75aVUj5LktJ6jNBMRcohjAe3zrQ5IrQCnBR/rB0Y8hEg04nTGIRkTFU=
Received: by 10.36.56.4 with SMTP id e4mr623771nza;
        Fri, 09 Jun 2006 15:59:44 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 9 Jun 2006 15:59:44 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21566>

Redhat is looking for a scheme to sync the disk system of their
stateless Linux client. They were using rsync and now they are looking
at doing it with LVM.

What about using git?

-- 
Jon Smirl
jonsmirl@gmail.com

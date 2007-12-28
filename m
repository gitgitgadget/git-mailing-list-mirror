From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Committing, pushing and pulling for Multi-GIT-Module project
Date: Fri, 28 Dec 2007 13:43:37 +0600
Message-ID: <7bfdc29a0712272343j6c9b460eq97f17cea9f3a9c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 08:44:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J89sz-0007UU-15
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 08:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbXL1Hnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 02:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbXL1Hnk
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 02:43:40 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:50142 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbXL1Hnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 02:43:40 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3724328fkz.5
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7bXjXXEwRKhZEc98tZGoiOn0yRBCq02Bz8aP1HgBLDY=;
        b=nDEbMbfgDXD2QbY1SIWfO3O2SkETZNRot6+74W/nf5SmHGJmmcvkQmVfnDWrLRkSxhuJUiI6H8OlDHDVT7aZujTg5fiBLbsnVk6iRZa98UWqyV0DgLA/tCgladFmfGL4tPLIR7N152m3FVfaD7cGr4ULqUJt8PjokGpODBY8L/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DVaebNuqeqVHM6qsDXKi/AweujgjyYTIM2Q2SkBAdl5ABuKr3nmN6TEQmHwnIlVRJMxWFXnDFfbO0d2eI/Vp/7XYZ+BDDNURWF24YrrDpFsO1fZq/+2bBim6kVV8PfFmidj2p/aPEhZm08oFz2+dFHiNeBDT3a58+O1g4GUwxHQ=
Received: by 10.78.133.2 with SMTP id g2mr10815424hud.26.1198827817846;
        Thu, 27 Dec 2007 23:43:37 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Thu, 27 Dec 2007 23:43:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69278>

Hi,

Compliments of the new season.

I am working with a multi-git-module project, I was wondering is it
possible to commit, push and pull all the modules at once? For pull I
think it is said explicitly that it has to be pulled individually. Is
it the same for commit and push?

Thank you & best regards,

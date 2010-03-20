From: Andre Ferreira <greiskul@gmail.com>
Subject: SoC line-level history browser question
Date: Fri, 19 Mar 2010 23:13:54 -0300
Message-ID: <1129eaaf1003191913t4b4c3474r87687d6fceaf88ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 03:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsoCu-0000hq-An
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 03:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab0CTCOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 22:14:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:30428 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0CTCOQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 22:14:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so211962fgg.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=usN2z0uKdAAhsxupta9gtHRjb1y6CGzlADzc22dy7vs=;
        b=l5dKduPqXUMNejyd6EVQX3YHezFa8paJrRSgSX37vvcDhjsQU0IDwIl14I/KGzRQNJ
         uPZJN0uiq+Far1vqagNuzhyDE8rEe6ggIj39yK2zdqm5nw2YWt6a5rvUv1Tjuwbheuca
         6zoVk44NXK5/ZmoEzd+jfeOeurNkwDOYL0E0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=CLg6Op/8wTgCe4KKi9MHM01RjeC5zVkIbn2JK9f2NBilb4X3099EeL5bM2euF/14r/
         puJIDRmj5l8U3UDUbBhjn/13kNBjruF8e7W+xvcOSF8C7j3Pmn1Zt6R2juhWKy9/7DlB
         TI7O3ZsgfOZVSvHXLFD//MflD9t9KK7qwZAuU=
Received: by 10.239.164.134 with SMTP id t6mr181089hbd.2.1269051254157; Fri, 
	19 Mar 2010 19:14:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142670>

I would like to know how the interface (the command line arguments
passed to the program) and output should look like (a rough example
would be fine).
I'm very interested in participating in Google Summer of Code, but
living in the Southern Hemisphere means that I would have to do it in
parallel with my university classes, therefore limiting the scope of
projects that I can handle. The line-level history browser appears to
be well within my reach.

Andr=E9 Ferreira

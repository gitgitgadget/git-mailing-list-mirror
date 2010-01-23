From: =?ISO-8859-1?Q?Andr=E9_Harms?= <andre.harms@kuhlsolutions.de>
Subject: Modern Git GUI
Date: Sat, 23 Jan 2010 22:40:21 +0100
Message-ID: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 22:40:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYniW-0005rh-Ra
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 22:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0AWVkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057Ab0AWVkY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 16:40:24 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:52878 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0AWVkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 16:40:23 -0500
Received: by bwz27 with SMTP id 27so1865330bwz.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 13:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=SY3yTSSYyvwb2gtUCg1C9TqvCd40sLV/onyEMnxqTBk=;
        b=T7Rz37fF6AkMmXDxqUtRFZdpykhm42xOD4ZrBVYx2yD+3VWwpc8JnwlfBvMwfmzXUw
         DbOSTHBIZ98eQP1di/fEFpnXkZDJ+WiVUr2SapKX4e5RdMqqh4dV/1uzLXLfUyZZXr2A
         Rm1hQIgzsxZdI8A4xvBeyVLPJtIZQnvFyEcaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=vGkkPQeyxZ1w9z0J9wtV02nWf6N6dqCHa0fZ3yrEOqnwhUIm5rsdJWBC29rBub7oxp
         pwACq+Z2uZnEwpSAcETFAjA+yZmclltPP3dDOFOXGrOSL0BqxqdwYweKwlU0q/a2Nwv4
         +uGzBGj4DKoDvmdM2BZrwpsIyaaJczz4BihyU=
Received: by 10.204.11.2 with SMTP id r2mr2630691bkr.30.1264282821470; Sat, 23 
	Jan 2010 13:40:21 -0800 (PST)
X-Google-Sender-Auth: 720038159af33a24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137864>

Hi,

I know there are several GUIs out there for Git. They are all
functional and most of them can be used in the daily work with Git.
In my opinion one thing combines them: they aren't very pretty.
I currently prefer the CLI to work with Git because it's quick and I
am happy with it. But I think there are people out there, who don't
want to use the command-line because they are afraid of doing
something wrong or anything like this. Additionally the CLI and
unattractive GUIs are barriers to people who are not familar with a
SCM-system.
So I thought about developing a new kind of GUI for Git that looks
modern and attractive (you know... some eye-candy stuff) and that is
easy to use. In addition I thought about a built-in console (like we
know it from first person shooters) so that also people who prefer the
CLI might use this GUI application too.

Is there anybody who agrees or disagrees? I really would appreciate
some feedback about that idea.

P.S.:
Normally I come up with such ideas to the public and ask what others
think about it when I have some mockups. I am sorry that I haven't any
right now.

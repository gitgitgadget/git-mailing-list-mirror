From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: clearcase migration to git
Date: Thu, 2 Dec 2010 09:14:31 +0800
Message-ID: <AANLkTintgZKHW+9aeqN=JPG34X6wqeCNOC0jpdFaWmrN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, lynn.xin.lin@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 02 02:14:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNxkv-0005N1-5F
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 02:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab0LBBOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 20:14:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55619 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0LBBOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 20:14:32 -0500
Received: by qwb7 with SMTP id 7so7756596qwb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 17:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=oPtOSXIUoazHZeRfzL6tMSj9DyTtCS2qEEkE2SRCFUU=;
        b=B4avDMYwr3PDnbY94Y2zK5XYyPWOA4bTdK6pnXUb8/VoJO5QSrtvDFS6doli36yqA7
         HGdvCPKGFvZpTJwoU0//JGYAN2JIdxkR7f59sa8eWJkxG8UJRTG0Bk4YgOGkJpWr3iYE
         89msJhPEQGJ8ZwhaLNbsa3rWhRYjKJNCqKLXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wLOR0+Zi9eGj/gezd3cIIH3fNCdtx9MF3weUylwBqaJlhiHmdMi6ZuS2ZTa7+aHHB7
         JAEHxNsleP4RBacG2n1dQ9gpEs5NcEUDMqvhORFNfGOgmgUCHP2sTkGLYwa9hA4EtOka
         VaLv9IRXLrsF5euhJED6LTvIcHPV7cYfiTN1c=
Received: by 10.229.245.4 with SMTP id ls4mr8025010qcb.32.1291252471534; Wed,
 01 Dec 2010 17:14:31 -0800 (PST)
Received: by 10.229.216.199 with HTTP; Wed, 1 Dec 2010 17:14:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162659>

All,
    is there any tools recommended that migrate clearcase to git?

Thanks
Lynn

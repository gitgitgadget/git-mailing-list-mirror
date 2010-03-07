From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git push question
Date: Sun, 7 Mar 2010 17:11:42 +0530
Message-ID: <b42431c81003070341u4a89578aw4357e7aef84ffb61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 12:41:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoErl-0000tk-0f
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 12:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab0CGLln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 06:41:43 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34986 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab0CGLlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 06:41:42 -0500
Received: by pwj8 with SMTP id 8so3247890pwj.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Ag+b9USdfdAr58X0e7DFuU64D2MzBi3xgO9j3PYvG6I=;
        b=Ih0Cb+JkgCVRUW6vF/SYg/GPUJYaQaK8fpH2e4bb4cgB8rUcXpx7bdFdlPz0XrGYoX
         lefEZz04lSWFr1SuJhAnMS8wgs5ztrIVviWp3s6CfUoxJ5qYsaRfxSea03pLPVLrkQek
         D5v08yGDAP81DvNYe9dV3FIxXi2q5xEl6Gclw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=NmSMyRLaSV+JOwVqmVr4dp+erFkfyV2WCT6p5bDWboFLQWWE+a1XtEjjf5Tptk97V4
         P0biGVS+jMExK0TN4OySjbScxMgXCu5MVHIyEtI9/yIy6jkV2c+QLYXILfZgWFsfwasW
         UW+bpI9llnq96ojiX/SwPy1tZzU4AF3Ab8aDE=
Received: by 10.142.75.20 with SMTP id x20mr2272161wfa.114.1267962102152; Sun, 
	07 Mar 2010 03:41:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141670>

=A0 =A0Hi

=A0 =A0I am asked to explore GiT as version control tool by my employer=
=2E

=A0 =A0I have discovered that one can set up property like
=A0 =A0"git config user.name piglet "
and commit will show this fictitious name instead real name forvaidya@g=
mail.com

=A0 =A0How do I ensure that a correct name is stuck at the time
receive-pack operation when user pushes changes to auth repository

-Mahesh

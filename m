From: Geoffroy PLANQUART <geoffroy@planquart.fr>
Subject: git commit -S documentation
Date: Wed, 9 May 2012 00:12:12 +0200
Message-ID: <48CBB45F-BF3B-470D-B80B-D0CD788E0081@planquart.fr>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 00:12:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRsdr-00017g-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 00:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843Ab2EHWMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 18:12:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57121 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2EHWMQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 18:12:16 -0400
Received: from [192.168.0.101] (neu67-4-88-160-66-185.fbx.proxad.net [88.160.66.185])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LqJhV-1RwecR3qFt-00dv8e; Wed, 09 May 2012 00:12:15 +0200
X-Mailer: Apple Mail (2.1257)
X-Provags-ID: V02:K0:xoq+Oe1YP0y7S/5oVomlZAQTSrAQuhnvqsleu0KGrjJ
 yD/+Ii0SeJ75vIm7QYjPJ6ju0RLZ7n4Gom0aW1m4EQyaRj7y3E
 ffFJGPMfVJdlp88shZ9TIlcoUeZKyFxv3A3oGCpNoJvDtKddyZ
 +u3QS9ZECwK1CfN2c0JsTiM96AHPNOX2o+GJ/ZbZK1P7ck0PNm
 ZEAFDc+6zs2LwkCDTUswBymti4aYAUcEy3E88BRHvypqQItnTG
 jGMaEXTSpeQ/m3mm5BVsbhKoi5x3OICrgx0/jG8CKL3cApcmgk
 O4fnTe3TMQvk4J8wfLh9rt4z+A4fUVAJxlsjq3Bfp41Xgfg+n9
 1LBbYqsyHKyc8Nwsaem2aYyaVHbXMz9M3oEEX+E0tDSKs1SlrX
 cVH9CFp9sl3fQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197428>

Hello,

I recently discovered the git commit -S option, but I can't find any documentation about it. I've search the local manpages (both archlinux & mac) and the website before posting.

Are there any information about it, and the way it can be configured and used?
I'd like more information on it and then perhaps make it automatic (without an alias if possible) if it's possible to check the signature in the log or somewhere.

Thanks in advance,
Best regards,

Geoffroy
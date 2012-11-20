From: "Joao Vitor P. Moraes" <jvlppm@gmail.com>
Subject: gitk: Portuguese "Ignore space change" translation
Date: Tue, 20 Nov 2012 08:03:29 -0200
Message-ID: <CADJyvEdgeC1fHWz9sU6RDUcrfXbkk5qZ6RVBp5iYUcvbnh2BdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 11:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TakgD-0000Nb-QV
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 11:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab2KTKDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 05:03:30 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49835 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab2KTKDa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 05:03:30 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so332722vbb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 02:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Pjvq0j29Fg1+vLGzKYikfq7NwC2iLSGLHz21b3PlhxU=;
        b=CERW98L8D+9dUUktC9AWevjRv4HGnT89SR0rfwQ7/6oZxdH7v/jrtf9ZWFk7xZ8EOC
         pmhGHv2FB7GauTpv2HkHXWOHYJIydtg5s839m2BxUa4QvT0mvLwNPGBd2DxDhWFNSz8L
         Vw2ugI8Nk/K7cH3n4HpaPJUCG+JV/zmbdLFZm6715r/+vMQ1wfIkuYMTQ/3nx229pZIr
         AgCmKNsb7Qo/M+V/gXVPpgsvZJd3JYyUDlEMTRepW3jj8LrPNkiCOnC4AcEKDqPCS7iF
         dDjXbdgDkjl4LkSEn3R7Pzlh31bLp2nRSeZme1HhZXcsxthl/OUpbw8o/MnsJw2s1RKk
         724Q==
Received: by 10.52.180.225 with SMTP id dr1mr20151444vdc.2.1353405809394; Tue,
 20 Nov 2012 02:03:29 -0800 (PST)
Received: by 10.58.241.167 with HTTP; Tue, 20 Nov 2012 02:03:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210087>

Inside gitk there's a checkbox which says:
Ignore space change

It was translated to portuguese (pt-br) as:
Ignorar mudan=E7as de caixa

But that message in portuguese means:
Ignore case changes

that checkbox does not ignore case changes, but instead it ignores spac=
e
changes, a better translation would be

Ignorar mudan=E7as de espa=E7o
or
Ignorar espa=E7amentos
or
Ignorar espa=E7os

From: Anders Kaseorg <andersk@ksplice.com>
Subject: Re: [PATCH 1/2] describe: Use for_each_rawref
Date: Tue, 7 Dec 2010 13:26:45 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012071325100.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <20101207095818.GB1867@neumann> <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:27:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2Fe-000717-Gg
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0LGS0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 13:26:53 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38067 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab0LGS0x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 13:26:53 -0500
Received: by qyk11 with SMTP id 11so5303123qyk.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:26:52 -0800 (PST)
Received: by 10.229.81.74 with SMTP id w10mr6054962qck.75.1291746411132;
        Tue, 07 Dec 2010 10:26:51 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id nb14sm4590655qcb.36.2010.12.07.10.26.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:26:50 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <alpine.DEB.2.02.1012071320240.23348@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163107>

On Tue, 7 Dec 2010, Anders Kaseorg wrote:
> Signed-off-by: Anders Kaseorg <andersk@ksplice.com>
>=20
> diff --git a/builtin/describe.c b/builtin/describe.c

(Gaaah, sorry, I accidentally used format-patch -p here.  Won=E2=80=99t=
 happen=20
again.  :-) )

Anders

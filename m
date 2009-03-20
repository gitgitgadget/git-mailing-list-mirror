From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked branch
Date: Fri, 20 Mar 2009 10:42:18 +0100
Message-ID: <3F6729A7-76FA-43F4-9538-D644B30576D7@wincent.com>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org> <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 10:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkbGw-000266-3n
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbZCTJmc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 05:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbZCTJmc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:42:32 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:42071 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZCTJmb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 05:42:31 -0400
Received: from cuzco.lan (207.pool85-53-9.dynamic.orange.es [85.53.9.207])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2K9gIVF004348
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 20 Mar 2009 05:42:21 -0400
In-Reply-To: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113925>

El 20/3/2009, a las 10:29, Johannes Schindelin escribi=F3:

>
> Often, it is quite interesting to inspect the branch tracked by a =20
> given
> branch.  This patch introduces a nice notation to get at the tracked
> branch: 'BEL<branch>' can be used to access that tracked branch.
>
> A special shortcut 'BEL' refers to the branch tracked by the current =
=20
> branch.
>
> Suggested by Pasky and Shawn.

What does BEL actually stand for? I read Shawn's suggestion, but it's =20
not immediately clear to me what "BEL" means.

Cheers,
Wincent

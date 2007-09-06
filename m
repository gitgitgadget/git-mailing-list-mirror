From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/3] archive: rename attribute specfile to export-subst
Date: Thu, 06 Sep 2007 22:38:57 +0200
Message-ID: <46E06561.4020904@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site> <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org> <46E02FFF.8090902@lsrfire.ath.cx> <Pine.LNX.4.64.0709061811460.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITO88-0005li-92
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 22:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbXIFUjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbXIFUjG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 16:39:06 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:57671
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755478AbXIFUjE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 16:39:04 -0400
Received: from [10.0.1.201] (p508EE2E4.dip.t-dialin.net [80.142.226.228])
	by neapel230.server4you.de (Postfix) with ESMTP id 4AB13873B5;
	Thu,  6 Sep 2007 22:39:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709061811460.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57928>

Johannes Schindelin schrieb:
> The bigger question is now if these two patches should be folded back
> into your original patch series, or stand alone as commits of their
> own...

Yes, indeed.  I submitted them as add-on patches because I noticed the
first three are already in next, but I sure can make a fresh three-part
series based on master.  Junio?

Thanks,
Ren=C3=A9

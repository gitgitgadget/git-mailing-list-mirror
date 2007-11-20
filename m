From: Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN cc
Date: Tue, 20 Nov 2007 21:09:41 +0100
Message-ID: <mj+md-20071120.200931.23805.nikam@ucw.cz>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org> <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de> <7vd4ua3hww.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de> <mj+md-20071120.182204.515.nikam@ucw.cz> <7vzlx8k7dl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	=?iso-8859-2?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 21:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuZQ0-0003gD-Oa
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 21:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799AbXKTUJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 15:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759985AbXKTUJn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 15:09:43 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:58445 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759711AbXKTUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 15:09:42 -0500
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id B4E575BA31; Tue, 20 Nov 2007 21:09:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vzlx8k7dl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65574>

Hello!

> How about doing it this way?

Yes, this looks perfect.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

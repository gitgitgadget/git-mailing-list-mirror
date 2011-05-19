From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCH] add Android support
Date: Thu, 19 May 2011 19:30:41 +0200
Message-ID: <CB6373AF-1F26-4E4B-843B-B02C4FE60F96@gieschke.de>
References: <D2F37FDB-20C2-401A-AA90-DB4A50C27123@gieschke.de> <7vzkmmjqpx.fsf@alter.siamese.dyndns.org> <D01E807D-C82C-4A8F-9678-9CEA92C413DA@gieschke.de> <alpine.DEB.2.00.1105170842490.30333@tvnag.unkk.fr>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Thu May 19 19:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN73i-0004jn-UQ
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702Ab1ESRao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:30:44 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:54353 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933494Ab1ESRao convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 13:30:44 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 47B791D239F;
	Thu, 19 May 2011 19:30:43 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.4
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=-0.500, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LxGQTQFX1t-Y; Thu, 19 May 2011 19:30:42 +0200 (CEST)
Received: from dhcp208-43.rz.uni-freiburg.de (dhcp208-43.rz.uni-freiburg.de [132.230.208.43])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 061361D1E0B;
	Thu, 19 May 2011 19:30:40 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1105170842490.30333@tvnag.unkk.fr>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173975>

Am 17.05.2011 um 08:44 schrieb Daniel Stenberg:

> (lib)curl already has a dedicated makefile in the release tarball crafted for building it for Android. It should not be a major obstacle.

Thanks, I'll have a try but the instructions in Android.mk look kind of scary :-).

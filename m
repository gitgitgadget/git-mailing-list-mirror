From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Fri, 07 Sep 2007 09:11:20 +0200
Message-ID: <46E0F998.1080202@eudaptics.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0709061651550.28586@racer.site>	<7vk5r3adlx.fsf@gitster.siamese.dyndns.org>	<alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org> <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITY04-0002iw-Ng
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 09:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbXIGHL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 03:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbXIGHL0
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 03:11:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53323 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbXIGHLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 03:11:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ITXzs-0007XU-UG; Fri, 07 Sep 2007 09:11:21 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7FC3154D; Fri,  7 Sep 2007 09:11:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.355, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57993>

Junio C Hamano schrieb:
> This is a beginning of "git-merge-pack" that combines smaller
> packs into one.

This gives a new meaning to the term "merge". IMHO, "git-combine-pack" would 
be a better name.

-- Hannes

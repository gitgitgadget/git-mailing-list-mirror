From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH] git-help: add new options -w (for web) and -i (for
	info)
Date: Sat, 24 Nov 2007 18:33:26 +0100
Message-ID: <20071124173326.GA16637@steel.home>
References: <20071124051650.07fd275f.chriscool@tuxfamily.org> <20071124113421.GB2948@steel.home> <47482116.70600@op5.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 24 18:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivyt3-00065Q-QT
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 18:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbXKXRda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 12:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbXKXRda
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 12:33:30 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:13761 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbXKXRd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 12:33:29 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrGTAQ=
Received: from tigra.home (Fa9d9.f.strato-dslnet.de [195.4.169.217])
	by post.webmailer.de (klopstock mo50) (RZmta 14.3)
	with ESMTP id z002c8jAOHVpyW ; Sat, 24 Nov 2007 18:33:27 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6C141277AE;
	Sat, 24 Nov 2007 18:33:27 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id E823356D22; Sat, 24 Nov 2007 18:33:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47482116.70600@op5.se>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65955>

Andreas Ericsson, Sat, Nov 24, 2007 14:03:18 +0100:
> Alex Riesen wrote:
>> Christian Couder, Sat, Nov 24, 2007 05:16:50 +0100:
>>> +valid_tool() {
>>> +	case "$1" in
>>> +		firefox | iceweasel | konqueror | w3m)
>>> +			;; # happy
>> lynx, links and dillo?
>
> Why bother validating it at all? I might be using a script to

Kind of my point

From: Paul Wagland <paul@kungfoocoder.org>
Subject: Re: [PATCH 2/2] Fix up the arguments for git stash.
Date: Tue, 26 Jan 2016 07:21:06 +0100
Message-ID: <C8776441-3B93-42D3-A759-0AA918F0F97C@kungfoocoder.org>
References: <20160123012316.GA27965@wagland.net> <20160123013049.GB28197@wagland.net> <xmqqio2hdz48.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 07:21:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNx0m-0003M1-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 07:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbcAZGVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 01:21:53 -0500
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:51061 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173AbcAZGVw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 01:21:52 -0500
Received: from cpsps-ews08.kpnxchange.com ([10.94.84.175]) by cpsmtpb-ews10.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 07:20:46 +0100
Received: from CPSMTPM-cmt107.kpnxchange.com ([195.121.3.23]) by cpsps-ews08.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 07:20:46 +0100
Received: from kruimel.wagland.net ([86.85.102.39]) by CPSMTPM-cmt107.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.0.6002.18264);
	 Tue, 26 Jan 2016 07:21:49 +0100
Received: from [192.168.2.103] (mijnmodem.kpn.lan [192.168.2.254])
	by kruimel.wagland.net (Postfix) with ESMTPSA id B2F6561C6F5;
	Tue, 26 Jan 2016 07:21:36 +0100 (CET)
X-Mailer: iPhone Mail (13E5191d)
In-Reply-To: <xmqqio2hdz48.fsf@gitster.mtv.corp.google.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kruimel
X-OriginalArrivalTime: 26 Jan 2016 06:21:49.0650 (UTC) FILETIME=[D70B2B20:01D15801]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284778>

Fair enough. I'll re-roll the patches with improved comments, and get these out to the list today. 

Cheers,
Paul

Sent from my iPhone

> On 26 Jan 2016, at 00:21, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Paul Wagland <paul@kungfoocoder.org> writes:
> 
>> Signed-off-by: Paul Wagland <paul@kungfoocoder.org>
>> ---
> 
> This needs a better explanation than just "Fix up" in the title.
> What is broken in the current behaviour and what is the more desired
> behaviour?
> 
> Thanks.

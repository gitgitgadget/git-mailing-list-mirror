From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 8/6 v2] receive-pack: Send internal errors over	side-band
 #2
Date: Thu, 11 Feb 2010 20:04:22 +0100
Message-ID: <4B7454B6.50703@viscovery.net>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org> <1265767290-25863-2-git-send-email-spearce@spearce.org> <4B725CB1.1080908@viscovery.net> <4B726A8C.6010600@viscovery.net> <20100210173412.GG2747@spearce.org> <4B73C0FF.5020503@viscovery.net> <20100211150547.GL2747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 20:04:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfeL1-0004cD-TW
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 20:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487Ab0BKTE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 14:04:26 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:13632 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756351Ab0BKTE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 14:04:26 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2EFDD1002A;
	Thu, 11 Feb 2010 20:04:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100211150547.GL2747@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139618>

Shawn O. Pearce schrieb:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Sorry, still no joy - the terminating NUL is missing (I should have  
>> noticed this in your v1 already).
> 
> Why is it necessary?

It isn't, sorry - I'm sick, and it shows :-/ Your version is fine.

-- Hannes

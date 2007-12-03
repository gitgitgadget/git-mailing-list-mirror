From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Many things pushed out to 'master'
Date: Mon, 03 Dec 2007 12:58:42 -0800
Message-ID: <7vwsrvh4vx.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
	<7vabosse23.fsf@gitster.siamese.dyndns.org>
	<7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712031109380.27959@racer.site>
	<7v1wa3iquj.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712031838450.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 21:59:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzINh-0002Fw-2z
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 21:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXLCU6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 15:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXLCU6s
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 15:58:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46209 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbXLCU6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 15:58:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7FBDA2F0;
	Mon,  3 Dec 2007 15:59:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E1769B6D7;
	Mon,  3 Dec 2007 15:59:06 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712031838450.27959@racer.site> (Johannes
	Schindelin's message of "Mon, 3 Dec 2007 18:39:14 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66955>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 3 Dec 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > But I remembered that you requested a mode for signed tags where they 
>> > would just be copied.  I just realised while implementing "verbatim" 
>> > that "ignore" does just that.  Maybe we should rename this mode to 
>> > "verbatim"?
>> >
>> > And maybe you want to make it the default (even if I think that this 
>> > will result in more surprise moments than the current mode which 
>> > aborts).
>> 
>> I did not hear others agreeing with me, so let's respect the original 
>> author's thinking.
>
> But the original author already admitted that the original naming was 
> stupid...

Ok, send in updates, please.

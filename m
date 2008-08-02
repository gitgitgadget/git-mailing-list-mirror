From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui translators - please update translations if necessary
Date: Sat, 02 Aug 2008 14:51:11 -0700
Message-ID: <7vej57cchc.fsf@gitster.siamese.dyndns.org>
References: <20080802211714.GG24723@spearce.org>
 <7vod4bccx8.fsf@gitster.siamese.dyndns.org>
 <20080802214930.GA25311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPP1O-0003Vy-AN
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYHBVvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbYHBVvR
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:51:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYHBVvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:51:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1488F4B358;
	Sat,  2 Aug 2008 17:51:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8DE274B357; Sat,  2 Aug 2008 17:51:13 -0400 (EDT)
In-Reply-To: <20080802214930.GA25311@spearce.org> (Shawn O. Pearce's message
 of "Sat, 2 Aug 2008 14:49:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21B7C2F6-60DD-11DD-8A34-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91190>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Grepping po/*.po and po/git-gui.pot for POT-Creation-Date reveals that
>> po/de.msg is much more recent than po/git-gui.pot and all others are
>> translating the same POT.
>> 
>> Perhaps you wanted to update git-gui.pot first before sending this request
>> out?
>
> Oh.  Its updated now, but msgmerge on my system is busted and won't
> update the po files themselves.  *sigh*

I think that's Ok.  msgmerge and edit are in the translators' bailiwick.

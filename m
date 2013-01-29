From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 23:06:08 +0000
Message-ID: <20130129230607.GG1342@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
 <20130129194846.GD1342@serenity.lan>
 <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
 <7va9rroazl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 00:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0KGE-00082p-Kv
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 00:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752Ab3A2XGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 18:06:18 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41962 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab3A2XGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 18:06:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 50068866009;
	Tue, 29 Jan 2013 23:06:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZtT+Fh1qZlH; Tue, 29 Jan 2013 23:06:14 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 43F70CDA61E;
	Tue, 29 Jan 2013 23:06:09 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7va9rroazl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214981>

On Tue, Jan 29, 2013 at 02:55:26PM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > I don't want to stomp on your feet and poke at this file too much if
> > you're planning on building on top of it (I already did a few times
> > ;-).  My git time is a bit limited for the next few days so I don't
> > want to hold you up.  I can help shepherd through small fixups that
> > come up until the weekend rolls around and I have more time, but I
> > also don't want to hold you back until then.
> 
> I can work with John to get this part into a shape to support his
> extended use sometime toward the end of this week, by which time
> hopefully you have some time to comment on the result.  John, how
> does that sound?

My email crossed with yours - that sounds good to me.  If
da/mergetool-docs is in a reasonable state by tomorrow evening (GMT) I
should be able to have a look at it then - if not I'm happy to hold off
longer.


John

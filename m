From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: [PATCH] Fix break in git-rev-list.txt
Date: Thu, 23 Aug 2007 01:29:18 +1000
Message-ID: <46CC564E.10609@gmail.com>
References: <11877706831306-git-send-email-qtonthat@gmail.com> <7vbqczkhvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 17:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INs9I-00022F-H1
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 17:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763220AbXHVP3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763414AbXHVP3a
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 11:29:30 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:38652 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763313AbXHVP3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 11:29:22 -0400
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=kingbee.home)
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1INs91-0004Oj-BW; Thu, 23 Aug 2007 01:29:19 +1000
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7vbqczkhvb.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56390>

Junio C Hamano wrote:
> It was a major plus that the input format is mostly readable as
> straight text, but this was one of the sore points in our
> formatting.  In the description part of a definition list, we
> indent the first paragraph but append the second paragraph and
> later with '+' without indenting (we would rather keep the
> second and subsequent paragraphs aligned with the first one).
> However, it appears that the definition has to be a single
> paragraph and not any longer in such a list anyway.

For your info (not implying what is "wrong" or "right"), without
the second '+' it will generate new paragraph with correct indentation
on my system here.

Quy

From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Mon, 8 Apr 2013 14:59:57 -0400
Message-ID: <20130408185957.GM27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <1365376629-16054-2-git-send-email-aaron@schrab.com>
 <20130407235112.GH19857@elie.Belkin>
 <20130408000845.GH27178@pug.qqx.org>
 <7vehekykan.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHIS-0003oJ-KG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935444Ab3DHS76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:59:58 -0400
Received: from pug.qqx.org ([50.116.43.67]:35684 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935135Ab3DHS76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:59:58 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id B4E2757E03; Mon,  8 Apr 2013 14:59:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vehekykan.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220493>

At 11:00 -0700 08 Apr 2013, Junio C Hamano <gitster@pobox.com> wrote:
>Aaron Schrab <aaron@schrab.com> writes:
>> Good catch.  I'll fix that in the next version.
>
>Thanks.  The patch otherwise looks good to me.

Great, I'll plan to send version 2 of this series later today.

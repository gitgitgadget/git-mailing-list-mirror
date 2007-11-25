From: David Brown <git@davidb.org>
Subject: Re: [RFC] best way to show diff of commit
Date: Sun, 25 Nov 2007 15:43:10 -0800
Message-ID: <20071125234310.GA26458@old.davidb.org>
References: <20071125211831.GA21121@artemis.corp> <20071125212748.GB23820@fieldses.org> <20071125220902.GB21121@artemis.corp> <7vfxyuj70i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Pierre Habouzit <madcoder@debian.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 00:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwR8v-0001hH-3U
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbXKYXnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 18:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756887AbXKYXnS
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 18:43:18 -0500
Received: from mail.davidb.org ([66.93.32.219]:47593 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458AbXKYXnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 18:43:16 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1IwR82-0006u8-Ag; Sun, 25 Nov 2007 15:43:10 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vfxyuj70i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66027>

On Sun, Nov 25, 2007 at 02:27:09PM -0800, Junio C Hamano wrote:
>Pierre Habouzit <madcoder@debian.org> writes:
>
>>   Hmm it doesn't because I would have to call git commit -v each time I
>> commit and well I _like_ having the status better. And moreover I want
>> the diff to go in a separated buffer too.
>
>I've never felt it a problem while editing the log message in Emacs.
>
>Don't enhanced vi implementations let you split the same buffer into
>two allowing you to view different portions of it these days?

Yes, certainly with vim, which is what most distributions seem to include
as the enhanced vim.  I have noticed that there seem to be fewer vim users
that figure out these kinds of things than emacs users, though.

Dave

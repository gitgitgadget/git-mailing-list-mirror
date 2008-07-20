From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sun, 20 Jul 2008 10:41:38 +0400
Message-ID: <20080720064137.GA9654@2ka.mipt.ru>
References: <20080719174742.GA4253@2ka.mipt.ru> <7vfxq521ab.fsf@gitster.siamese.dyndns.org> <7v8wvx211n.fsf@gitster.siamese.dyndns.org> <20080719195909.GA5093@2ka.mipt.ru> <7v8wvxzg97.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 08:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKSd0-0002T1-L5
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYGTGlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYGTGlo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:41:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.80.65]:38730 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbYGTGln (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:41:43 -0400
Received: from 2ka.mipt.ru (localhost [127.0.0.1])
	by 2ka.mipt.ru (8.14.1/8.14.1) with ESMTP id m6K6fcZP010894;
	Sun, 20 Jul 2008 10:41:38 +0400
Received: (from johnpol@localhost)
	by 2ka.mipt.ru (8.14.1/8.12.1/Submit) id m6K6fcui010885;
	Sun, 20 Jul 2008 10:41:38 +0400
Content-Disposition: inline
In-Reply-To: <7v8wvxzg97.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89164>

On Sat, Jul 19, 2008 at 03:00:20PM -0700, Junio C Hamano (gitster@pobox.com) wrote:
> > I posted it so it would be stored in archive, that old enough git
> > version does not work with recent trees, so one should upgrade if this
> > error occures.
> 
> Thanks, but you are about 5 days too late ;-)
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=88402

Better late than never :)

-- 
	Evgeniy Polyakov

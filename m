From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Fri, 06 Jun 2008 16:23:03 -0500
Message-ID: <BxRFEBn7RnPYtqjijr1wmeVSsVQ66p-LzwRJ9L0uPfzz4tAN1SeHsw@cipher.nrlssc.navy.mil>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com> <alpine.DEB.1.00.0806051946100.21190@racer> <484969F0.1030704@gnu.org> <alpine.DEB.1.00.0806061911300.1783@racer> <Jx4nZtFGdU-iUxlX24G6lzMyWe99Z53jtjQp9T9qkMJ1iZC0eZW6xg@cipher.nrlssc.navy.mil> <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Cedric Vivier <cedricv@neonux.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:24:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4jPu-0004kV-VB
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbYFFVXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758664AbYFFVXQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:23:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35361 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099AbYFFVXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:23:16 -0400
Received: by mail.nrlssc.navy.mil id m56LN4Ta022541; Fri, 6 Jun 2008 16:23:04 -0500
In-Reply-To: <d45085aa0806061417ue3f1f51i6580acbb51070e5b@mail.gmail.com>
X-OriginalArrivalTime: 06 Jun 2008 21:23:04.0537 (UTC) FILETIME=[81AD9C90:01C8C81B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84119>

Cedric Vivier wrote:
> On Fri, Jun 6, 2008 at 11:04 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> But can't that be just as easily done by piping through sort? (I understand
>> there is a platform which lacks the sort utility, boohoo)
> 
> Yes, but sort does not have a natural sort option afaik.
> If natural sort is the default order though then piping through sort
> to get things in "non-natural" order is easy enough indeed.

Yes, that's what I meant.

-brandon

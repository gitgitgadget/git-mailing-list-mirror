From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Pushing a new branch to a remote and tracking it
Date: Tue, 27 Jul 2010 21:20:31 -0400
Message-ID: <AANLkTikatSEN1TpZ3SrEVcSOUo+tg=LpUc9d76o3dPXU@mail.gmail.com>
References: <AANLkTikxmhndNqGDpwfBm41OuaPvnB=2xqp6gkYOTQiF@mail.gmail.com>
	<m26300o8nm.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 03:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdvK1-00075B-S0
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab0G1BUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 21:20:33 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64889 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab0G1BUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 21:20:32 -0400
Received: by pwi5 with SMTP id 5so679086pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:20:31 -0700 (PDT)
Received: by 10.142.155.13 with SMTP id c13mr480098wfe.288.1280280031102; Tue, 
	27 Jul 2010 18:20:31 -0700 (PDT)
Received: by 10.142.98.16 with HTTP; Tue, 27 Jul 2010 18:20:31 -0700 (PDT)
In-Reply-To: <m26300o8nm.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152026>

On Tue, Jul 27, 2010 at 6:35 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Bradley Wagner <bradley.wagner@hannonhill.com> writes:
>
>> Is there a more elegant way to: 1) create a branch, 2) push it to a
>> remote and 3) continue to track it.
>
> git push --set-upstream (since v1.7.0)

Thanks! That's exactly what I was looking for.

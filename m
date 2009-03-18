From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC] Colorization of log --graph
Date: Wed, 18 Mar 2009 18:04:09 +0100
Message-ID: <adf1fd3d0903181004k2554ae90uc101aad64947be7@mail.gmail.com>
References: <20090318100512.GA7932@linux.vnet>
	 <loom.20090318T164728-444@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 18:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjzDD-00029C-Jo
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbZCRREN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbZCRREN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:04:13 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:62212 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZCRREM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:04:12 -0400
Received: by fxm2 with SMTP id 2so144637fxm.37
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 10:04:09 -0700 (PDT)
Received: by 10.103.228.7 with SMTP id f7mr634991mur.130.1237395849135; Wed, 
	18 Mar 2009 10:04:09 -0700 (PDT)
In-Reply-To: <loom.20090318T164728-444@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113630>

2009/3/18 Eric Raible <raible+git@gmail.com>:
> This may be clueless (I suspect that it is) but I have never understood
> the meaning of the different line colors in gitk.  They seems arbitrary to me.
>
> I get that the current HEAD is represented as a yellow dot, but that's it.
> (As an aside, it might be nice if merges had a different color dot than
> normal commits).
>
> Can anyone clue me in?

Gitk paints lines of development (lineal history without merges nor
forks) with the same color.

HTH,
Santi

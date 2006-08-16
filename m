From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression and dictionaries
Date: Wed, 16 Aug 2006 08:33:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com> 
 <20060816003712.32000.qmail@science.horizon.com> 
 <4b73d43f0608152243i15b37036x7aa50aa3afc2b02f@mail.gmail.com>
 <9e4733910608152250h1bcb8bf5qebb29ef84b971abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Rigby <jcrigby@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 08:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDExh-0000Cl-RQ
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 08:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWHPGdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 02:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWHPGdG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 02:33:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:13985 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750944AbWHPGdF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 02:33:05 -0400
Received: (qmail invoked by alias); 16 Aug 2006 06:33:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 16 Aug 2006 08:33:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608152250h1bcb8bf5qebb29ef84b971abd@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25499>

Hi,

On Wed, 16 Aug 2006, Jon Smirl wrote:

> On 8/16/06, John Rigby <jcrigby@gmail.com> wrote:
> > Sorry if this is off topic, but could the dictionary be used to make
> > git-grep alot faster?
> 
> It would be almost instant.

But only if you are not using a regular expression, but a single word.

Ciao,
Dscho

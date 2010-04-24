From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 00:38:21 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100424043821.GA21973@thyrsus.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <4BD1EE10.4010009@gmx.de>
 <k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com>
 <4BD21CAB.8060903@gmx.de>
 <20100423222522.GA21224@thyrsus.com>
 <s2mb4087cc51004231638u6f0110fcxd4369ff8d81c7c06@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 06:38:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5X8Q-0001DG-It
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 06:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab0DXEiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 00:38:23 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35221
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab0DXEiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 00:38:22 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 555C3479E92; Sat, 24 Apr 2010 00:38:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <s2mb4087cc51004231638u6f0110fcxd4369ff8d81c7c06@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145656>

Michael Witten <mfwitten@gmail.com>:
> On Fri, Apr 23, 2010 at 17:25, Eric Raymond <esr@thyrsus.com> wrote:
> > Commands that are simpler
> > to mentally model, because they don't have a lot of exception cases,
> > are better.
> 
> The UNIX philosophy: "Provide mechanism, not policy."

And commands that are simple, orthogonal, and easy to mentally model do that.
You get to provide the policy you want by scripting them.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

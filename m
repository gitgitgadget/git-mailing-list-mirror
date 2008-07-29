From: Petr Baudis <pasky@suse.cz>
Subject: Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 04:02:12 +0200
Message-ID: <20080729020212.GI10151@machine.or.cz>
References: <20080729000103.GH32184@machine.or.cz> <7vk5f5o6em.fsf@gitster.siamese.dyndns.org> <20080729011404.GI32184@machine.or.cz> <fcaeb9bf0807281855w3b06f624q18f5ac76a3bb405c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 04:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNeYW-00053O-C3
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 04:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYG2CCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYG2CCP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:02:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39780 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbYG2CCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:02:14 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E1E0E2C4C021; Tue, 29 Jul 2008 04:02:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0807281855w3b06f624q18f5ac76a3bb405c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90549>

On Tue, Jul 29, 2008 at 08:55:32AM +0700, Nguyen Thai Ngoc Duy wrote:
> On 7/29/08, Petr Baudis <pasky@suse.cz> wrote:
> > On Mon, Jul 28, 2008 at 05:55:45PM -0700, Junio C Hamano wrote:
> >  > Petr Baudis <pasky@ucw.cz> writes:
> >  >
> >  > > (What feature in Git or a Git-related tool would you implement, given 24
> >  > > hours staight and unlimited pizza supply?)
> >  >
> >  > "Use 'assume unchanged' bit to implement narrow checkout".
> >
> >
> > I think Nguyen Thai Ngoc Duy is already working on this? (Though I think
> >  he does not use the assume unchanged bit; but this will be likely done
> >  before the end of September.)
> 
> You are welcome to do ;) I got to narrow checkout from subtree
> checkout where 'assume unchanged' bit was unapplicable so my approach
> is a bit different, but probably 'assume unchanged' bit is the right
> way to go.

But I rather liked the elegancy of just narrowing this down to a
particular subtree. Is there really a good reason to generalize this
further?

				Petr "Pasky" Baudis

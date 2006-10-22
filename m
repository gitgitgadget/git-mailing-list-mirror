From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 11:05:25 +0200
Message-ID: <200610221105.26421.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <453A7D7E.8060105@utoronto.ca> <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 11:05:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbZGj-00022W-D8
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 11:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWJVJFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 05:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWJVJFQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 05:05:16 -0400
Received: from hu-out-0506.google.com ([72.14.214.238]:11944 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932303AbWJVJFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 05:05:14 -0400
Received: by hu-out-0506.google.com with SMTP id 28so737122hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 02:05:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YWgp2LuxW2Kg/MkrrtYKTDC1OUqIDM7SgT11ZsIWU0WLi1zc6WX0wHbeMagWvelfJ51WpyCyJHDewAuR34P8VzGZ2tCToUybBp+ftYth2flMCXiVba/nljW7qIOmidaxqmkJQuTUyNC77FrFF4I+SwSNaWxocOlZ9yyqAyLS3d8=
Received: by 10.67.97.7 with SMTP id z7mr5067602ugl;
        Sun, 22 Oct 2006 02:05:12 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s7sm957410uge.2006.10.22.02.05.11;
        Sun, 22 Oct 2006 02:05:12 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29712>

Jan Hudec wrote:
> On Sat, Oct 21, 2006 at 04:05:18PM -0400, Aaron Bentley wrote:
>> Carl Worth wrote:
>>> On Thu, 19 Oct 2006 21:06:40 -0400, Aaron Bentley wrote:

>>>> Bazaar encourages you to stick lots and lots of branches in your
>>>> repository. =A0They don't even have to be related. =A0For example,=
 my repo
>>>> contains branches of bzr, bzrtools, Meld, and BazaarInspect.
>>>=20
>>> Git allows this just fine. And lots of branches belonging to a sing=
le
>>> project is definitely the common usage. It is not common (nor
>>> encouraged) for unrelated projects to share a repository, since a g=
it
>>> clone will fetch every branch in the repository.
>>=20
>> Right. =A0This is a difference between Bazaar and Git that's I'd
>> characterize as being "branch-oriented" vs "repository-oriented". =A0=
We'll
>> see more of this below.
>=20
> This is one of things I on the other hand like better on bzr than git=
=2E
> Because it is really branches and not repositories that I usually car=
e
> about.

That's probably because you are used to Bazaar-NG, and your habits
speaking. Think of git clone of repository as of bzr "branch".

=46or example git encourages using many short and longer-lived feature
branches; I don't see bzr encouraging this workflow.
--=20
Jakub Narebski
Poland

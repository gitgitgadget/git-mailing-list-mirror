From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gitk : french translation
Date: Sun, 08 Nov 2009 20:30:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911082010590.16711@xanadu.home>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
 <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com>
 <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com>
 <20091107025439.GC13724@vidovic> <vpqtyx5nql0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_9kozAKzTBamVijbOWrvnFA)"
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Emmanuel Trillaud <etrillaud@gmail.com>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 09 02:31:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7J6H-0005SS-8I
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 02:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbZKIBag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 20:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZKIBag
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 20:30:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35914 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbZKIBaf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 20:30:35 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KST001ULIV2TP10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Nov 2009 20:30:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqtyx5nql0.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132436>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_9kozAKzTBamVijbOWrvnFA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Sun, 8 Nov 2009, Matthieu Moy wrote:

> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> >> > - make some consistency changes
> >> >  * s/diff/différences/
> >> >  * s/patch/correctif/ everywhere
> >
> > I disagree here. Words like "diff", "commit", "patch", etc should be
> > kept as is. Translation of those terms make things harder for the users.
> 
> Metoo.
> 
> One day or another, the user will have to face the words "diff",
> "commit" and "patch" even in a 100% french-speaking context (for
> example when requesting help and someone answering "open a terminal
> and type 'git commit --whatever'" or so).
> 
> Matching the command-line concepts and the GUI concepts is made really
> hard by over-translating.

Striking a good balance is the key.  Not translating enough might simply 
look "cheap" to a new user who was not exposed to the concepts in the 
first place.

It is not like if we were facing issues like:

"Made in Turkey" -> "Fait en dinde"

"arm rest and pad assembly" -> "armer le repos et rembourer l'assemblée"

It's like those stu**d people who decided that "email" was too hard to 
translate.  So they declared that "email" was "imél" in French.  
Fortunately some non European people came up with a refreshing idea and 
translated "email" into "courriel" instead.  And with a step back, you 
must admit that "courriel" is so much clearer and more descriptive 
semantically.

Therefore I think that it is a good thing to _try_ to translate stuff 
appropriately.  but this is often much harder than it may seem.

> (and BTW, "correctif" is not a very good translation of "patch", since
> a patch is not necessarilly a correction of something).

In this case I think "retouche" would be a better choice.


Nicolas

--Boundary_(ID_9kozAKzTBamVijbOWrvnFA)--

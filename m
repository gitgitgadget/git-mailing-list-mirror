From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: excluding files from a merge
Date: Sun, 15 Mar 2009 21:45:02 -0400
Message-ID: <76718490903151845i27984ccaqbfb289eff69f7dc6@mail.gmail.com>
References: <loom.20090315T011519-497@post.gmane.org>
	 <76718490903150547o1c791d35r5d71000b481f443b@mail.gmail.com>
	 <20090316071440.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Jacobs <djacobs7@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 02:46:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj1uU-0007dt-OJ
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 02:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbZCPBpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 21:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbZCPBpF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 21:45:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:54635 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZCPBpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2009 21:45:04 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1334542rvb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g6BWNfXjvYbGxk3J22Ax2nnkucv33s2X8eeKRkufDZc=;
        b=JfxdjRyz9RltAPmT647Es3OlsG+UNkIo3MgQ9DDT/dltanWUXyijOheuYe9f7w6d8e
         PasVEJSynSbv7r8ESK/pB3oS37tcUNB9oR7DDn7+aruRdiYNrmAVmisD3PaWd7Kn5xO7
         PGrcxTe4xrCYeSBH6iJoHTPADy0jEe9D1X1kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jM5Q4yEugspbXGwxAX61EEh/xjIkkv1fnlnyUSekEPp9LS515K7sQSvcCJHINculmj
         fvth01WO3PcC65LNgdEBxUT6Om1Ju/pyzMCWFQrd4j7phqcvj2rwp9IIE/ArgsTygoa9
         2YORXU7WOtbjXejXt5X3O/E8nZFTxaDVuKWK0=
Received: by 10.141.161.6 with SMTP id n6mr1939984rvo.0.1237167902900; Sun, 15 
	Mar 2009 18:45:02 -0700 (PDT)
In-Reply-To: <20090316071440.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113305>

On Sun, Mar 15, 2009 at 6:14 PM, Nanako Shiraishi <nanako3@lavabit.com>=
 wrote:
> Would it help to have the final summary by Sitaram Chamarty
>
> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git/=
110697
>
> somewhere under Documentation/howto?

I don't think it would hurt. A good explanation of remote tracking
branches, local branches, and what --track means might not hurt
either. :-)

j.

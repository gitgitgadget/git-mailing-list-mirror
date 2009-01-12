From: jdelstrother@gmail.com
Subject: Re: grammar patches not best use of talent
Date: Mon, 12 Jan 2009 08:54:16 +0000
Message-ID: <57518fd10901120054o5fbe78f8he0a54f6d62216ad5@mail.gmail.com>
References: <7vprito32u.fsf@gitster.siamese.dyndns.org>
	 <87bpudp77t.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Jan 12 09:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIaF-0004Bp-1r
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbZALIyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 03:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZALIyT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 03:54:19 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:53705 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZALIyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 03:54:18 -0500
Received: by bwz14 with SMTP id 14so31748789bwz.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 00:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=L6FGTYmYuELmKwos86dcsx5p4wLjcOfKab7WOOYMax4=;
        b=upd90vgHeEtKqUZHEekmuz5/eYBRGV/3p/fG8Y7dLiH2zwll3p7Hr01c7e+C8W63j3
         BgMpQfXjCDM97AbkfQDEhTnxceP3F78YxAPwY3jLksXE9Kw3KWao17WpAko64oQz1b8b
         iuFROuNSxZw90esAsx0toNOBEKyGRqZyaeEuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZIx3Iqd/E6Fq8TB+EFeYF5zmk5SyFtGtOdNJoLyA8i8ZnbkAfzVdgnlND1tMjnzOl5
         brkRfZDM91LHAZmBZzhLAjyaIpfzwmLfby8Lz6GYAn55G6Obfz/i42XXq79CmnAP77an
         8Hu9LmaKYGtryeHqsKk7+nYl+61ZLb55BxyeI=
Received: by 10.223.116.18 with SMTP id k18mr20753891faq.104.1231750456352;
        Mon, 12 Jan 2009 00:54:16 -0800 (PST)
Received: by 10.223.105.9 with HTTP; Mon, 12 Jan 2009 00:54:16 -0800 (PST)
In-Reply-To: <87bpudp77t.fsf_-_@jidanni.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105305>

Wait, "a handful X" is now a legitimate form of "a handful of X"?  I
assumed they were due to non-native speakers.

On 1/12/09, jidanni@jidanni.org <jidanni@jidanni.org> wrote:
> I've decided to back out of my plan to patch grammar.
> $ perl -nwle '/\w+\s+handful.*/i&& print $&' Documentation/*|sort -uf
> a handful commits on top of that,
> A handful documentation fixes.
> A handful documentation updates.
> a handful example hooks are copied in the
> a handful fixes to run it
> a handful of examples:
> A handful of sample hooks are installed when
> a handful pack-objects changes to help you cope better
> a handful small fixes to gitweb.
> a handful the real changes in non-zero
> first handful of characters, show the full
> only handful hexdigits prefix.
> only handful hexdigits prefix.  Non default number of
> only handful hexdigits prefix.  This is
>
> At first some of the above lines irritated me, but who am I to say
> that English must be said like my mom says it, and is never allowed to
> evolve further. Nope, I'll stick to correcting 2+2=3 type things.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

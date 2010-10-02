From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Sat, 2 Oct 2010 20:26:43 +0200
Message-ID: <AANLkTik-+5uCuRkEqE6_e5dcYsY8vhbX-qYXpaL2f9CP@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 02 20:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P26oS-0003Kz-CK
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 20:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab0JBS0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 14:26:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62500 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0JBS0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 14:26:44 -0400
Received: by iwn5 with SMTP id 5so5155033iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=yf28S2Fz0KslRlttY13TjLC1qD8P92HUMhUF9KalC7g=;
        b=rOUFFRwB+gDDbdklI71ouoK/yB1gdUpFCOJmMbOztK4IjuvRLgfQtdu6i8pAfV8GFs
         m6O4isvsLi+QFkmN5HXniuCUtaU7nmLkviyODL8JA43tNT1bDv+/8b98fEg3J+NWHb2t
         f1oya1XtQioeu7E74FKOwpACC0VEQw9dnf1sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=dIMcUD3bV3/2q8GbdUFhaoBn0ugbD2//2j2360xNwX/h/YoHLFWCcrA+VqNl4W24or
         U/nuzlMvYWmeSxOq+hJXpEDkCNLKfHZRBnWDZJ0pmJQIa/DQT04vkHnjEqmmFQt4052+
         tIEHcKOIHLMn9a5maRC6+gr6B/KE0+0TUxw/Y=
Received: by 10.231.30.68 with SMTP id t4mr7557961ibc.129.1286044003811; Sat,
 02 Oct 2010 11:26:43 -0700 (PDT)
Received: by 10.231.130.141 with HTTP; Sat, 2 Oct 2010 11:26:43 -0700 (PDT)
In-Reply-To: <20100925230022.6e2fd389.coolzone@it.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157810>

On Sat, Sep 25, 2010 at 11:00 PM, Rico Secada <coolzone@it.dk> wrote:
> Hi all.
>
> Would it be a bad idea to split the Git mailing list up in several
> sub-categories?
>

As far as I can tell, splitting a list into -dev and -user lists tends
to drive the quality of the -user list down. The people with actual
knowledge about the topic ask themselves: "Why do I keep answering
questions from clueless noobs, while all the action I care about
happens on another list?" and end up leaving the list altogether.
I think that as long as the traffic on this list remains manageable,
we should keep everything as-is.

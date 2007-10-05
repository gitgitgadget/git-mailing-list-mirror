From: "Miles Bader" <miles@gnu.org>
Subject: Re: A few usability question about git diff --cached
Date: Fri, 5 Oct 2007 19:41:37 +0900
Message-ID: <fc339e4a0710050341v11a7f9f7j3cf24403d2231886@mail.gmail.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	 <5ACC5CA7-8314-4035-94EC-190138A25EBD@wincent.com>
	 <buoejga14qg.fsf@dhapc248.dev.necel.com>
	 <0A7AA9C3-6D9E-4B14-822D-05232F0EAF99@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:41:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idkcw-0001qM-8F
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbXJEKlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753864AbXJEKlj
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:41:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:36707 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbXJEKli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 06:41:38 -0400
Received: by wr-out-0506.google.com with SMTP id 36so349786wra
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=n5rJnU08WlD/3ZE8TRag4Tu0H6rmnCHnZJUfOVMcG5I=;
        b=jQi+B3gTOjTouQ1qm2HmikhwS2a2d5sMOFm1Et2IsZ0nzPAHmgF6WQpjOHIkoSmsD14RrPLNudfIiX0/89QNf8B/I6056KS7ZtZK2RxqJxTmAbHhWhgRjZQwK9P31XptuhDdu2KTBDLsvDHp3Px4MZDCE8D5uPRL2VnGktdNPA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Q1x8JWje7xcA5SisY7JVkyYmYPTszOFWLvGF4RVZ077NKveEONLk6O7iV63Xaf1SWXZvclnXToMRadlJXvj7/VTWv5C3cZW0Y53FNi3g8Zpy4GgSX1QR1dvRuqdBcM7brFiZrYF134XiOx+mBwHp99PtPs8HSepQuY7+7+9VvXA=
Received: by 10.151.10.7 with SMTP id n7mr479084ybi.1191580897653;
        Fri, 05 Oct 2007 03:41:37 -0700 (PDT)
Received: by 10.90.105.17 with HTTP; Fri, 5 Oct 2007 03:41:37 -0700 (PDT)
In-Reply-To: <0A7AA9C3-6D9E-4B14-822D-05232F0EAF99@wincent.com>
Content-Disposition: inline
X-Google-Sender-Auth: dd7235df3be626e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60067>

On 10/5/07, Wincent Colaiuta <win@wincent.com> wrote:
> > Personally all I want is a short-option alias for --cached!
> >
> > Hopefully something easily type-able (not uppercase)...
>
> Did you see the aliases I posted earlier in the thread? I can't think
> of anything shorter or semantically clearer than "staged" and
> "unstaged".

The words are ok, I guess, but aliases are not a replacement for short
options.... really all frequently used, non-dangerous, options should
have a short variant (and diff --cached meets both criteria handily)!

-Miles
-- 
Do not taunt Happy Fun Ball.

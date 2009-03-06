From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/3] improve bash completion of fetch, pull, and push
Date: Fri, 6 Mar 2009 07:43:04 +0100
Message-ID: <fabb9a1e0903052243o286e76c1mf70dbcb9b3daca6c@mail.gmail.com>
References: <cover.1236314073.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 07:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfToF-0003o5-B2
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 07:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbZCFGnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 01:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZCFGnJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 01:43:09 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:55680 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbZCFGnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 01:43:08 -0500
Received: by fxm24 with SMTP id 24so240146fxm.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 22:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nakmWPJxKoTbbnY6HbOAlnRsOF6LBTbcQs3KkjuFjiM=;
        b=Y/CTVC/7YiH+LlWemsd547LrEXZRdlp0oCZsFAQBpoWrfMx0hvUhuU59JrD+d8AG+0
         PkIrYQzK/rgPiv8XH52yEh3pR+x6Tg5jNbDh88EyjQQriVhNyLjMx72qS+UfNHWnDaLV
         xYEkzqPHNiyOmNLW2Mn2JIj5jz0dc6mLi1VVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pehB10kbxStoc1LJv0NgtiplsMJUESAnOILtfEN8rfqEvFQCiN3VgnUYNJeYIR1qKc
         Bx5gdbr4picj1ZCzTe5WvAUI/m9wzI7C7U8oe0773wi7jOo+6b4OHrRcjwzQ29wnP6SV
         O6X7NOqkwTQbvoXkUkP6kfKmWkfDtTSF7y0Wg=
Received: by 10.103.24.17 with SMTP id b17mr915398muj.21.1236321784406; Thu, 
	05 Mar 2009 22:43:04 -0800 (PST)
In-Reply-To: <cover.1236314073.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112391>

Heya,

On Fri, Mar 6, 2009 at 05:39, Jay Soffian <jaysoffian@gmail.com> wrote:
> This series is intended to fix the original issue, as well as provide
> --option completion for all three commands. And, I made a clean spot, so
> I had to clean up a couple other things.

Thanks, I can't comment on the quality of the patch, but I'm glad you
went through the effort of fixing this :).

-- 
Cheers,

Sverre Rabbelier

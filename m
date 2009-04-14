From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 INTRO] I hope this will do it!
Date: Tue, 14 Apr 2009 11:26:14 -0500
Message-ID: <b4087cc50904140926o4bb48c1bs66946078bb3cd2f9@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <7vy6u36215.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtlUZ-0005A7-Ql
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 18:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbZDNQ0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 12:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZDNQ0Q
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 12:26:16 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:58068 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbZDNQ0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 12:26:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3008430qwh.37
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DiCmgrODxUyHd5twtiS9Jf7DDdPp/CTpA1EsgU1nEXU=;
        b=YCD1sRohEzkse2+Xahzc0PGUAjHBofDk6j3KMXys+2TEwzDMEsMEmEVb6Wpwq6DMiU
         Z0bRGsy9ewwTpzdR2ya6wSVPg3kXbmulHmBXjqyib60z8d9gQYCuGXlcKxtuZOCY+K+M
         HDTIGxhHmlxYS1pfPSKDeTC7oaaeB1TxWgIlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lWkQuD//4IEcg6cQWo8UT9sUT0tOoJqPVFmxBFKltaBUbr1JcdcqfaQ8xLOojlM2rb
         lmGh/jvsAcwSbGS/n+hpBhNGP/+fihy3Y/clv8ia8x2rGpldmXDw6xqPO8Y9GBCV/nEU
         75MAHHlBquQp3vU+oyms79lw1b7haiBKLqQIM=
Received: by 10.224.19.141 with SMTP id a13mr7602663qab.60.1239726374259; Tue, 
	14 Apr 2009 09:26:14 -0700 (PDT)
In-Reply-To: <7vy6u36215.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116545>

On Tue, Apr 14, 2009 at 04:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> It is unfortunate that the interesting ones begin at 10th in the series,
> which are beind the 9th one that is a "churn in the middle".

(http://marc.info/?l=git&m=123959564630157&w=2):
> The general rule of thumb is to do such a clean-up before you start to work on something of substance.

(http://marc.info/?l=git&m=123914648915106&w=2):
> a good rule of thumb when preparing a series is to have this kind of obvious clean-up first, leaving enhancement patches later in the series.

I guess, then, this whitespace patch is something of substance---an
enhancement ;-D

... or unnecessary "code churn"... I suppose.

From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 02:39:35 -0500
Message-ID: <76718490903022339j79f41516kd97a96b2515677d@mail.gmail.com>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
	 <1235865822-14625-2-git-send-email-gitster@pobox.com>
	 <1235865822-14625-3-git-send-email-gitster@pobox.com>
	 <20090301031609.GA30384@coredump.intra.peff.net>
	 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
	 <20090301100039.GD4146@coredump.intra.peff.net>
	 <20090301170436.GA14365@spearce.org>
	 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
	 <20090303070937.GB30609@coredump.intra.peff.net>
	 <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePFS-0004Rd-HP
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbZCCHji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbZCCHji
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:39:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:15249 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZCCHjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:39:37 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2677310rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ib0pqX+js28VMe2UtNdgT2VJB1hyM+iPfA1fXklgfSs=;
        b=BdT6TKhlpbTF4jT1vJt3SZ/AMaUrJY0PkefRcSSOOVG3Dl3ii4myYnYNAQOMg8CPju
         9ik9ht0EoZRdZuZU8mXNJnm/8YslvNSvlpzp32vPjx6wRGViLjorvkCwljuJUb81f72a
         10j4wM5pHsl75otaK8s5A/exmY/XnH0xf43tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r5hnrvIkNYmg7NA9Rp9GYEkEZOHlBxQoAIxvqhELvzQWj9Yf7lMkxMDjZbSzt7hKUi
         VhSwuKksAPo8b2y3JV+6iSsCJoqMaUei9rtvL5RpKgNP4in1m5J/6IGHmNdjL1EnDHhg
         OfjnkRzOSb00R4BFHGTtkAq4cbe1wkyiyeS0o=
Received: by 10.140.187.10 with SMTP id k10mr3370882rvf.81.1236065975457; Mon, 
	02 Mar 2009 23:39:35 -0800 (PST)
In-Reply-To: <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112014>

On Tue, Mar 3, 2009 at 2:37 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I concur w/Jeff and I think git probably should not as well.

Er, w/o being told to do so explicitly. I'd argue "--init" is a saner
option name than "--create" though since you say "git init", not "git
create" to make a repo.

j.

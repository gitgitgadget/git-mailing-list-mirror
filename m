From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Mon, 21 Jul 2008 00:50:40 +0200
Message-ID: <bd6139dc0807201550v27d6db3epd0d0b4bc663e0351@mail.gmail.com>
References: <20080720205125.GP10347@genesis.frugalware.org>
	 <7vsku44679.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhkm-00013N-Gm
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbYGTWum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYGTWul
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:50:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:48659 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYGTWul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:50:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1294214wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NE/n2wLVpkaLUxT07QE1+AD4YqCLf/0Od3Y5YmombAc=;
        b=oDGw6k86xSHbtp7DogqloRI5MI/LGWEjhryPEgtQDoS/qiU4TOAVGsufcKVnm94M7p
         fPrvSvXqGw8SHKwL15RHTI2L5Hmdf3FjFtJI7zZyKgt0j5qx/PJdTqyJrdvNSRjiVVhC
         c+mVny5MG9X+xv0uRWMZRu6CktFegyrgFh9kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ED0wRX4by5kM25WjsQLGsJmhbz1WnvbOo8dwynZqcDbdBD2bGw7nvF0uzp4DPB5Hly
         qYegGOaURpolcnU793l4WmOfKijAvyuZeciOHGS0SsS4p2Rz3tH8Yo20WXZgB7Uxr2QI
         26gi8TcOHGfH3RrqnVVTeEjCjG4eRQgJ5SEY8=
Received: by 10.142.166.1 with SMTP id o1mr1039644wfe.345.1216594240751;
        Sun, 20 Jul 2008 15:50:40 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 15:50:40 -0700 (PDT)
In-Reply-To: <7vsku44679.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89254>

On Sun, Jul 20, 2008 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I could make "What's cooking" not a follow-up to the previous issue, or
> perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.

The downside of this is that it'll be less easy to see the difference
with the previous version. GMail tries to mark text that appeared a
previous mail in purple, so new text 'stands out' in the regular black
(it's not that good at it though).
So WRT to not making them follow ups, an improvement would be a diff
with the previous version online somewhere, although I guess the
http://tinyurl.com/todobranch is exactly that modulo your (Junio's)
comments on the topics.

-- 
Cheers,

Sverre Rabbelier

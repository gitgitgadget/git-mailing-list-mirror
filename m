From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 15:00:28 +0100
Message-ID: <20071031140028.GA30207@diana.vm.bytemark.co.uk>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InECN-0005o1-0F
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbXJaOFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbXJaOFU
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:05:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3693 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbXJaOFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:05:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1InE7Q-0007s6-00; Wed, 31 Oct 2007 14:00:28 +0000
Content-Disposition: inline
In-Reply-To: <20071031134358.GD15182@dpotapov.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62833>

On 2007-10-31 16:43:58 +0300, Dmitry Potapov wrote:

> I believe that the issue is with Junio's mail client. Indeed, the
> context encoding for the mail *body* was specified as 8859-1, but
> that should have none effect on fields in the mail header, because
> any field is the header should be either printable ASCII or encoded
> to contain only ASCII characters as specified in RFC 1522:

Yes. But it's the body that's been mangled -- specifically, the
Sign-off line.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

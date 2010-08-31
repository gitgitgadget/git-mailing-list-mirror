From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 10:32:14 -0500
Message-ID: <20100831153214.GI2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSqo-0000SZ-2a
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557Ab0HaPeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:34:06 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44144 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757224Ab0HaPeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:34:04 -0400
Received: by qyk33 with SMTP id 33so6765575qyk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8BLdFg/2ZCQsKHJqJZitni5DT5LnkxjsP2tSwMQaTvE=;
        b=TsknkG/bGg7ab1+yXunwII6gPYO9lmAP3nv6DWnHdWFd0B9emMbK+rHi7tUQRmXzN2
         HRsmb3sBi/6WbhXPrI9ZTOHCYA+KF16H8Z5hRzaHaDHBLcd09tcHAKOGhsE6XFaeBK99
         RHKO6Sj+G/BoetpD3YCx1MJPNWIju1OdmZjlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LtxsS11I1xaVWFSppdT6h62MfHCQHrwM8FONWw3RAjGI1UMVxgCEKr1u9qvig41dak
         +0rtmcHTO6frdiYLHgr3Ob7KjWxvRP+cNekJUolCTp8JbhXn+s9+l3G4TyhFjnZXBzzZ
         BmqgF2i8PwKBep9Sy5CvqWGfqkH67NoeLWx/8=
Received: by 10.224.104.153 with SMTP id p25mr4111458qao.98.1283268843551;
        Tue, 31 Aug 2010 08:34:03 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm9828757qcs.27.2010.08.31.08.34.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:34:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154913>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Now that Git has the infrastructure for translation in next I'm going
> to start submitting patches to make the main porcelain translatable.

I've written some comments on specific patches; the rest looks good
to me.

Thanks for moving this forward.

From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 27 Apr 2008 14:44:32 +0800
Message-ID: <46dff0320804262344h5c8651ednb11e913a2b800eb4@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
	 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:45:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0dU-0007ft-9o
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbYD0Goe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbYD0Goe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:44:34 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:44795 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbYD0God (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:44:33 -0400
Received: by an-out-0708.google.com with SMTP id d31so1099647and.103
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 23:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cOyT7ys6k9P5UP4p8N5Mi9FkWC75PQRAExFycPm6gnQ=;
        b=R/c+u4iQnV3qOD3cI4N1bUxLInEAFbSuE9ISP6BGrQfZErdSxvxskw6VO39d7wA3uDRnlFZ8r9xmV1zM+CXOd0Z6/oUs0B0ywSqm40NejjYMRrf5/RbYRTLEnncPiUBrnxahR66MvP7HfKK7Ik9YvdaWDr+Q5O8gRSbbXPFudQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OPy8JXRUfH7Svd4IVU2qYyZ9+1Y0lTR2A/nXr0TIXQKtSLVNsSZ4074YMshCFSMBgNRTzuc8Y3B+G7ejtAvRM3KrWI4fKUVj/FGksuAdEVugZdLCyzmzCd7qzeePknM/cU4ejNF4MFIcYttr39P1dr0nw64QCREXV0iX2qwhwJA=
Received: by 10.100.112.9 with SMTP id k9mr10107841anc.78.1209278672492;
        Sat, 26 Apr 2008 23:44:32 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 26 Apr 2008 23:44:32 -0700 (PDT)
In-Reply-To: <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80423>

On Sun, Apr 27, 2008 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * py/submodule-2 (Wed Apr 16 22:19:31 2008 +0800) 1 commit
>   - git-submodule: Extract functions module_info and module_url
>
>  Not going well.
>

Hmm, i wonder how this series can go well. Or this series is totoally
bad and should be discarded.


Ping Yin

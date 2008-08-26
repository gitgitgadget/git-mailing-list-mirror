From: "Eric Raible" <raible@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Tue, 26 Aug 2008 01:24:43 -0700
Message-ID: <279b37b20808260124q5b1c834cna1afd328766adf1@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 10:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXtsA-0006FT-LQ
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 10:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbYHZIYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 04:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757381AbYHZIYp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 04:24:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:27190 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbYHZIYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 04:24:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2225556wfd.4
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cJWz7x5ebv1Z73kCEqWs3TeCuqs5EScQPm3x9+bcAs0=;
        b=D7GFNgTF5zoanP3081o0zlwfJySnvlzSc9HRn1f96QE/leq13BMbsfayIXSBo/2k9Q
         0fHa3AYKnAbhIJvE8Ezs2rei/8XXthRYnEmMm0BUxK3NE6rfJEOsOwf7x0TjHbFeKXhz
         JfKa2BD4UWUpvL0JWxKWMkypkBSAbRvK9Yf1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bRG1Oeuv3Pi6zad9DekCqG7SPIZz7E/t8ywNcM26oPl9NHtnkN84FD7NxH4Gck3MYC
         sym/dQtdPTBaM19w5m8vZaJUnj9gOk1mPj9DAvp6zYktSkAe23kaK9xulxCQZkZtIAN9
         1DkQKQfdA99IEmrhhO8E3mQZQBx5cMgZ+Oc5w=
Received: by 10.142.178.13 with SMTP id a13mr1902021wff.53.1219739083436;
        Tue, 26 Aug 2008 01:24:43 -0700 (PDT)
Received: by 10.142.187.19 with HTTP; Tue, 26 Aug 2008 01:24:43 -0700 (PDT)
In-Reply-To: <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93726>

On Tue, Aug 26, 2008 at 1:16 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> +If Alice wants to visualize what Bob did since their historie forked

s/historie/histories/

From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 08:19:15 -0500
Message-ID: <76718490902180519s3b5f4469m391aa34456059d37@mail.gmail.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
	 <1234911457-37188-1-git-send-email-jaysoffian@gmail.com>
	 <0E74A2BF-1E59-4D82-A750-380697667F10@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:20:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmM1-00080d-Mx
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbZBRNTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbZBRNTR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:19:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:58242 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZBRNTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:19:16 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2023666rvb.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YrlnULy5+MII76d0NhNPzg0DkZMnBR3YefZpisi8RAg=;
        b=ci4aFHnbFZKTVLz6MTdTPs17gVSfrlfZcKOpBVIHwfnhj863djqXdYoBcyJL1pUB8W
         2L1GuP3ts0EO4SeePtAQnmMQdrhIqOlsEKdWcNKPCpHvBHynH9ZCXdhDpevATqPx1KL3
         Qsvc3cXCpgVwxNm8wuNkLb/atkXX5r/UVLGy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oDliL9chL2oAOyyMPZQwJyiPnyu+Yx9CG+6z/QztJTZFkNxe5QvsRp5YdMdQbF4d0f
         TgzTTEwLckWAVMsW8Qtzl42jx43FP9yTfJ8kw1DxF+cOaYKgRa+1+tBj4z8shln1PWa2
         6mMdp7JK9nnnLfVLq6Ta4z4bdFGK+G1guwZmQ=
Received: by 10.140.164.6 with SMTP id m6mr3958634rve.144.1234963155523; Wed, 
	18 Feb 2009 05:19:15 -0800 (PST)
In-Reply-To: <0E74A2BF-1E59-4D82-A750-380697667F10@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110532>

On Wed, Feb 18, 2009 at 5:06 AM, Wincent Colaiuta <win@wincent.com> wrote:
> Perhaps my eyes are playing tricks on me but I see the original version
> setting MSG to an empty string and exporting it, and your version setting
> MSG to "1" and exporting it. So which one is wrong? The original or yours?

http://thread.gmane.org/gmane.comp.version-control.git/109897/focus=110462

j.

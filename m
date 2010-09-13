From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Mailing list headers: Date:<TAB> instead of Date:<SPACE>
Date: Mon, 13 Sep 2010 18:03:03 +0000
Message-ID: <AANLkTinEb9geKox+a+HosQn-g4eKd-DW4agRCf8yqv=k@mail.gmail.com>
References: <20100913150245.GT22527@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Klausner <tk@giga.or.at>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:03:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvDN6-0004Ca-2e
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab0IMSDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:03:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57558 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab0IMSDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:03:05 -0400
Received: by fxm16 with SMTP id 16so3312051fxm.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Gb5/m+u4vKvQa9DI27DzaEqxmzAcZf82YsU3G9lqe0E=;
        b=d9ysdQAZp+JIat/SxQ5gzDJGB4QPvEGq0lO7oMRELIa2ayqZJtmiY5Z/S2Cw+8qDdM
         MgNdIuelXkCIvBzdl67gwWK6lKOIwMqniew99VXJu5L8S7smsrvosnq7HJIOGAPFY+ZO
         k2EC5hQdQqm2O8ggwLQA9VqyxanEptYEjeE1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hw24N4begPe8Kj8DTLgAweCKeOFFFez08fHlJTbj3RWruzxxN0Rj2/DY0Jp12FkyUU
         V0At3QzFnzY+bqhUwkT/mR1lyosVTJB31m66cKzKJdiOZTt7s5wg0Qd6e+aZFw5dUkX+
         OUeLi8gZtGwagxSPOB/05Hprd/AS0/aUytJ5E=
Received: by 10.223.114.72 with SMTP id d8mr3665237faq.83.1284400983470; Mon,
 13 Sep 2010 11:03:03 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Mon, 13 Sep 2010 11:03:03 -0700 (PDT)
In-Reply-To: <20100913150245.GT22527@danbala.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156104>

On Mon, Sep 13, 2010 at 15:02, Thomas Klausner <tk@giga.or.at> wrote:

> While this doesn't seem to be forbidden by the RFC, I think it is
> at least uncommon, and here it causes trouble. Could you please change
> this?

Wouldn't it be better to just change tin to be RFC compliant?

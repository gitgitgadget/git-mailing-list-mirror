From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Configurable filename for what is now .gitignore
Date: Tue, 2 Sep 2014 06:33:02 +0700
Message-ID: <CACsJy8CwSD9Ux+vT9UQUPLFnXoGMn-fvraML+Sj79_et3wJ8WA@mail.gmail.com>
References: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
 <20140830054312.GA28512@google.com> <CAEp_DRATLprK9LZg45dn5LY=3C8cLM1BNg4rmi0XxJmdPhDGBw@mail.gmail.com>
 <CAEp_DRBM6cexcoBrYmEktZXh4WMzE-tYwCi80-THCNwJqthQ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Bostjan Skufca <bostjan@a2o.si>
X-From: git-owner@vger.kernel.org Tue Sep 02 01:33:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOb6Q-0007B3-3w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 01:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbaIAXde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 19:33:34 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51150 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbaIAXdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 19:33:33 -0400
Received: by mail-ig0-f174.google.com with SMTP id a13so4133381igq.13
        for <git@vger.kernel.org>; Mon, 01 Sep 2014 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l4u3Cp9LkYmKz1XEjIlFuupHZxeLxRYQK/cYtLateIA=;
        b=0M8mRpJ4NTGG4Da2h0nFQl3qqecranZ978XgmRB34e+mP4LneHNQ4xC4AWsesvk72o
         1nQKQu2ousC/dnKDPr8pXr/oGviEE8mMseccB2paPEoKozD488WrbdFYQDlsIXv0K2wH
         x2xPa1QcUgWwghIx50uqWeZ2CzMA8pCrQbHXKD2cGtask9l1ORF93z/nz492tD2PzrYL
         xmKpi9w7/P1XleS6fECEoG/FQcB/zLMlBGA8mflQkXZC1nxUaS+/QF15TPSR5vgTwpY0
         B/EEArCH+zb52HG6fWhGNeGMihRM2RXn8RWhhz1Nk692rlezefveBLzBXvwW4DaCi8QY
         8fJQ==
X-Received: by 10.50.171.199 with SMTP id aw7mr24924658igc.27.1409614413037;
 Mon, 01 Sep 2014 16:33:33 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Mon, 1 Sep 2014 16:33:02 -0700 (PDT)
In-Reply-To: <CAEp_DRBM6cexcoBrYmEktZXh4WMzE-tYwCi80-THCNwJqthQ=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256314>

On Tue, Sep 2, 2014 at 3:30 AM, Bostjan Skufca <bostjan@a2o.si> wrote:
> There is currently no way to transfer/share repository configuration
> between clones.

See http://article.gmane.org/gmane.comp.version-control.git/216624
-- 
Duy

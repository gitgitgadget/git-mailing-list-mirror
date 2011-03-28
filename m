From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC 2011
Date: Mon, 28 Mar 2011 14:48:57 +0700
Message-ID: <AANLkTi=3B7m4G1ceif8TRAoOv8eA8ueRjrFwfK+OyOUr@mail.gmail.com>
References: <AANLkTikQ6=CrWuMemwv38HnBKPnt8CjQWqYj7oA8zVZ4@mail.gmail.com> <AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karol Samborski <edv.karol@gmail.com>, git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q47Cm-0008NL-Ca
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab1C1Htf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:49:35 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:38275 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1C1Hte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 03:49:34 -0400
Received: by wwk4 with SMTP id 4so1450120wwk.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=//A7/HDpdWxtOm+LbyBA/2yhfk9ORKvIYijW54eI1oQ=;
        b=F9UpNqgh6VVFCXf3j2e/O1oL0kYPuVe6jZ1og/QH07UecyEuDhdrQVRJRSQ4Mi+G24
         hrIGvmMUPU0U7BrbNS2o3ty7+hdYS/dmwT1JoO1mk6kQUFXmXi6ewd53OsbzhnQhkJRf
         D0Bv/QWUA5i5RQn4zABVQsGxxCk6mJUIAsb/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PsN8TkXV4VEN+WwIJaz/VD99qvvSa1DjXoZDUspVFnJS3dXyl5Xl/xEL+8k7zjetfv
         YP3hAWErCTcG2XPVk8j+ZT7luAWdrhGDx88Ebmd43KfVxNFhLHYodUj75nYo1rkS51HM
         mQkPC8GTFeSvnN8HDH8qSQktTu8O+31FAG5I8=
Received: by 10.216.66.131 with SMTP id h3mr3690174wed.111.1301298573590; Mon,
 28 Mar 2011 00:49:33 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Mon, 28 Mar 2011 00:48:57 -0700 (PDT)
In-Reply-To: <AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170108>

On Mon, Mar 28, 2011 at 2:42 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> And by the way the same question has been asked recently and the
> answer was to search a mailing list archive for "low hanging fruit" as
> we don't use any bug tracker.
> You could perhaps search the source code for "TODO" or "NEEDS WORK" too.

Also search for test_expect_failure in t/ directory. I don't know how
hard those breakages are though.
-- 
Duy

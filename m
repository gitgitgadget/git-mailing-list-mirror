From: Derek Moore <derek.p.moore@gmail.com>
Subject: git-log man2html conversion broken: http://git-scm.com/docs/git-log
Date: Wed, 8 Oct 2014 12:49:54 -0500
Message-ID: <CAMsgyKadiE-HOH_oLK=Fc0UQXnEuUTMHmz3=9zRiMvU0fr4KvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 19:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbvN9-0006Ht-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 19:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbaJHRt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 13:49:56 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:38383 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaJHRtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 13:49:55 -0400
Received: by mail-oi0-f52.google.com with SMTP id a3so8445796oib.11
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=dnHyblpQA1Nntfpl+JX+4RhSZRGCd4phuWNoXk3X/NM=;
        b=HlM0qvxYBVgn/url9KjMzXwyGZ8FyInkQYq4AQRSSvWqZFc3zTFhw066cEGtleYO/S
         vk0H30M2re0lCRjtaPY4cp28s26e7Ys4Ao9AFrb5AsQbtvzmVjaKXxyuhmX78U90VdUB
         z+ux9unTBA+8O/3tQU1/FkjbzPBLrZkH0CNveajD1Wvx9OlALq6dA2UQug7LcG/DR7/L
         fL57K93oj7F4Ggq+rowh35CEtLDiuI9cSvehGwen+C3MS0COR0swcPqSiOy3h9Vnb11G
         0ITaALVLHZwcxDOLwGdHENH1CogYa7s9FL5X2QpBQg0WwtnPsh9yFcBUV4uethC/BKuX
         Z8vQ==
X-Received: by 10.182.47.232 with SMTP id g8mr5336593obn.85.1412790594792;
 Wed, 08 Oct 2014 10:49:54 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Wed, 8 Oct 2014 10:49:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The HTML for the git-log man page is being misrendered on the official site.

See the placehoders list under "format:<string>" in the PRETTY FORMATS section.

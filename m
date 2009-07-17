From: n179911 <n179911@gmail.com>
Subject: Is it possible to configure the color of git diff outpyut
Date: Fri, 17 Jul 2009 09:35:44 -0700
Message-ID: <3b9893450907170935k53baf50fue84fe619624a4489@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 18:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRqPW-0003Qi-8p
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbZGQQfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbZGQQfp
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:35:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:5659 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917AbZGQQfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 12:35:44 -0400
Received: by rv-out-0506.google.com with SMTP id f6so234430rvb.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=psH0Ka0kMly1HMksgwqBgI74BHzVOe3fhnU85v5ztIE=;
        b=uuFRv8rJI/U+Vv5rbwRJadipPC19an9VeOwGjYz7lwnelHt/WvL6eih+p59HuvBd4W
         tvPKKcSVvX8auQo5odIQS8NuLjraEmA8CiIFg+GKQNKLfAvP+WBkgEyVTSBZzSDgRmR3
         Q+W6VxU5zzBYIVCIXDrKvkNZ269xZDnNCeM4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=i9D5iAHatldmhqM++MSQwWkQ/1XvVWl9FiZZsamdYX8zYCV5/kPtqXUF7NnWB565Kb
         q2ptEGt53NVTWjoQi6ajgOu9dupGWOf/1Gs+9jpVGFkrr9Y4G63JCa6S+KMkXqYkWouX
         T06c/OEXok+Iz6ed26KBLMFkE3ddk6nkOf61c=
Received: by 10.140.157.14 with SMTP id f14mr924259rve.111.1247848544461; Fri, 
	17 Jul 2009 09:35:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123475>

Hi,

When I do git diff, for example, it has color output (red for "-" and
green for "+").
Can you please tell me how can I change the color used?

Thank you.

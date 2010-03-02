From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Google Gerrit
Date: Tue, 2 Mar 2010 16:10:57 +0200
Message-ID: <c1fb08351003020610q25b85b60hf9362aabc4b0126f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-kernel <linux-kernel@vger.kernel.org>, sop <sop@google.com>,
	git <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 02 15:11:19 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1NmSoZ-0006FN-BU
	for glk-linux-kernel-3@lo.gmane.org; Tue, 02 Mar 2010 15:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab0CBOLA (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 2 Mar 2010 09:11:00 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59915 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab0CBOK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2010 09:10:59 -0500
Received: by fxm19 with SMTP id 19so314941fxm.21
        for <multiple recipients>; Tue, 02 Mar 2010 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=OATj+F6Ut4gcS7zU3mW6bIrGkKCu844j8xgwXIhTA5k=;
        b=FHAWW/TH+zRFIimN+p9jembBsVbUj8qkNGdjzKa6X5R5xESfJ72Vc5vT264oeJMJ5B
         i8zLv1VyB45EanDg8mPA8vT/9grCpKa5InviESs/40Ln8N2OItvrGkBnsr4eYyVXDQeH
         hqSwCqNJQo6/Z35Srvc/tKKUTAN2gX/nPuU0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=GhExPX7LZ/sx6eNz6gU+WGHFHM47Zo3Q+7HcEyAqkuyp6Bc+VkzFPPZYifEe+FNjx8
         u72MCTZMUK3WAgPAVrcM0sq/+V/BgHIXU/Qw3CCZrlQyr4JKIndw4xvogFlAXu80Mc9p
         ZUXddnkUVJOWBUHqDHPpwB5HR7wL8wJU7dN04=
Received: by 10.87.66.24 with SMTP id t24mr6503348fgk.75.1267539057138; Tue, 
	02 Mar 2010 06:10:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141395>

Hi, what do you think about Google Gerrit ? http://code.google.com/p/gerrit/

see it in action here: http://review.source.android.com

quote:
"Gerrit is a web based code review system, facilitating online code
reviews for projects using the Git version control system.
Gerrit makes reviews easier by showing changes in a side-by-side
display, and allowing inline comments to be added by any reviewer.
Gerrit simplifies Git based project maintainership by permitting any
authorized user to submit changes to the master Git repository, rather
than requiring all approved changes to be merged in by hand by the
project maintainer. This functionality enables a more centralized
usage of Git."

git needs an friendly UI, web based is the future.

Maybe an integration with Wave.

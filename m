From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-add.txt: Order options alphabetically
Date: Wed, 1 Dec 2010 14:04:51 -0800
Message-ID: <39ABD9CC-45F4-4C2D-8081-56F9681C563C@sb.org>
References: <1291218145-13016-1-git-send-email-jari.aalto@cante.net> <1291229622.11917.14.camel@drew-northup.unet.maine.edu> <87bp55uw96.fsf@picasso.cante.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:05:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNunL-0004Pn-J4
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab0LAWEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:04:54 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47352 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab0LAWEy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 17:04:54 -0500
Received: by pwj3 with SMTP id 3so1202101pwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:04:53 -0800 (PST)
Received: by 10.142.180.4 with SMTP id c4mr9562312wff.146.1291241093720;
        Wed, 01 Dec 2010 14:04:53 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm530840wfh.15.2010.12.01.14.04.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 14:04:52 -0800 (PST)
In-Reply-To: <87bp55uw96.fsf@picasso.cante.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162620>

On Dec 1, 2010, at 11:29 AM, Jari Aalto wrote:

>    - You read from top to bottom, therefore A-Z.

What does that have to do with anything? Very rarely does it make sense to try
to read options in alphabetical format. If the reader is, in fact, reading from
top-to-bottom straight through, they will certainly appreciate having related
options grouped together.

>    - GNU project uses it in manual pages. It looks good, it looks
>      professional, it looks clean. And it works when searching (= no
>      oriantation problems regardless of tools; even when you print on
>      paper when you don't have any computerized aids to help your search.).

"Looks clean" is not a good reason to reduce clarity in the documentation.
Comprehension and ease-of-readability are far more important than visual
aesthetics.

-Kevin Ballard
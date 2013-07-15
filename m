From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] .mailmap: Combine more (email, name) to individual
 persons
Date: Sun, 14 Jul 2013 23:10:45 -0700
Message-ID: <20130715061045.GE2962@elie.Belkin>
References: <1373796899-23378-1-git-send-email-stefanbeller@googlemail.com>
 <1373796899-23378-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 08:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uybzq-0007Fi-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab3GOGKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:10:49 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50885 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab3GOGKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:10:49 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so10912495pac.12
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m38TKawNYpu+5KBSYLKMyidvG35xlbxcK3yUzaxA8ME=;
        b=u/RAsrhUqHROP/dnphaPEcvXMY61mvt7KRA0BqZzdiu00BHIijW+we08ovenHdqtA9
         t5QUq+RHXmG5xggrUfAKgKpPKv96HvdDg4948OwFNrpKbIwsd4w+1nuj482aq8nkSkKz
         T/cFXOfMsq9SsswZZeZodGZ5HrUv/s67X7F5YygD5ujkTp9+pmkmS7n5VraJcUmF584Y
         qcrcfbNr6n9rIJg7Vg39uXwaoZ1iu/DxJbpHORQlmbfH5vd5DVh42xgeWSht413pu4WO
         2EJNTGjqU7omnmXidPUCjNi3scC8zNfdfO+Wwqdpd/t8WULUoVlPnfgeTYamNemPxR6t
         W8pw==
X-Received: by 10.68.182.162 with SMTP id ef2mr52244053pbc.173.1373868648765;
        Sun, 14 Jul 2013 23:10:48 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id wg6sm58993196pbc.3.2013.07.14.23.10.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:10:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373796899-23378-2-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230422>

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

Markup and methodology look correct.

Fwiw,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Is this meant to be squashed with 94b410bb (.mailmap: Map email
addresses to names, 2013-07-12)?

Ciao,
Jonathan

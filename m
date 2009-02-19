From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not on 
	the last line
Date: Thu, 19 Feb 2009 18:53:36 +0100
Message-ID: <bd6139dc0902190953m195a56ey47aa9bf535c4d77c@mail.gmail.com>
References: <499D2478.6080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 18:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaD7h-0002SQ-EB
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 18:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZBSRxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 12:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbZBSRxj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 12:53:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:30928 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZBSRxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 12:53:38 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1272768fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=79IWn3ZcxqcDy8nWzgP/goJ9usqOsjJYgNw6GxXMQwA=;
        b=U55NQy8mSgRDO0IeF1nWa+zDl4vdSUz7HDVq/2RO0FepuItwg3YyNFb8w4Bu9fqFm2
         M0aGH1J/+p06iZSK/eVYb5KzaiTn8g3Wbe/7B1K8i9MwNARSd/niWrg7ceO3G7+4JsXM
         GMoCwnjiiNJAilTPKFw5Vjs6VDmPeyN7wL9mM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=NFWTGAJ6LdVPX9fZrWqYjIH29J7VaTnj1w0uOvk/TNAN8qfaVvB0EuFgebqo5Rm787
         KIQHBG4NMcolzyZOSGMRaZdrK3D1RlcrrS65qiDvg95a0tK9omlb+m6inEmhL6DqLgdp
         XnR8XryeSmvkIL+FBLSHfdvv4vlGgubwuSMOc=
Received: by 10.86.29.8 with SMTP id c8mr479231fgc.67.1235066016262; Thu, 19 
	Feb 2009 09:53:36 -0800 (PST)
In-Reply-To: <499D2478.6080501@gmail.com>
X-Google-Sender-Auth: bf6db67816dd8bd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110721>

On Thu, Feb 19, 2009 at 10:20, Yann Simon <yann.simon.fr@gmail.com> wrote:
> I hope this send will not be whitespace damaged.

You could of course send your patch inlined, but attach the patch as
well if you fear your MUA will damage the patch. That way the patch
can still be easily reviewed, and can be applied just as well.

-- 
Cheers,

Sverre Rabbelier

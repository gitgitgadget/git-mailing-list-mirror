From: Lucas Radaelli <lucasradaelli@gmail.com>
Subject: [Suggestion] add alt texts to the images of the git book
Date: Tue, 13 Oct 2015 10:53:19 -0300
Message-ID: <561D0CCF.8000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 15:53:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm01B-00065z-4m
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 15:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbbJMNxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 09:53:24 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33539 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbJMNxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 09:53:23 -0400
Received: by qkas79 with SMTP id s79so7437624qka.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=k5dnvpypZI20JPV0mtwTVnKnlNtt01NVbFicDi3ay7Q=;
        b=fVMYQzL6d0pfmEN80bFnqb9GAyOHBY/53DnjHlmeN5DIx3PAV98J2KDzFQj9j47rp8
         k/yPiRI2yWBLis26qSuV9HXCK6+26zyXtBr+GB4x+26InmYk8nU7Ms4SdWklcHQuNP3j
         OnELvVsKTc6mJMdemer0P7DZ6AbyLJt7pP66nNf4onX8ask01n1JAkVIEJwfJUA6OFX0
         QkBGpbhJ/q417r31cnYgaGSzKOe8+VXZKj5VTd+RLCd8cehHbpqq3g2nnb93MUUH6AIz
         BHS17yi9FoHA7ow95MFsTEEgOT9U7h+maqnIcOeCF5TScgW7NNxG5paMOGqPNd85+m5/
         qMHg==
X-Received: by 10.55.221.65 with SMTP id n62mr39282060qki.42.1444744403023;
        Tue, 13 Oct 2015 06:53:23 -0700 (PDT)
Received: from [172.29.71.48] ([172.29.71.48])
        by smtp.googlemail.com with ESMTPSA id h10sm1207743qgf.29.2015.10.13.06.53.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2015 06:53:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279501>

Hey there,

the book at https://git-scm.com/book/en/v2  (which is awesome btw, 
thanks for that!), contains a lot of images that are inaccessible to me 
because I am visually impaired. Not sure if they are really really 
important, but in some cases  it was a little bit complicated to follow 
some examples, more specifically, in the branching chapter.

Some outputs were pasted as plain text, which was much easier to follow, 
and I wonder if would be possible in the future to have all outputs 
pasted as plain text for easier reading?

Thanks.

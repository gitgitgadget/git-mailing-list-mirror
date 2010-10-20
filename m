From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Visualizing matrix questions in results of "Git User's Survey 2010"
Date: Thu, 21 Oct 2010 00:43:11 +0200
Message-ID: <201010210043.11341.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 00:43:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8hNW-0006wu-Ad
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab0JTWnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 18:43:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41753 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab0JTWnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 18:43:19 -0400
Received: by bwz10 with SMTP id 10so1797465bwz.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 15:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=RaAO4W8sF4bW2jWazDbQwq8fKYZxSoGxWQUsA07zfvs=;
        b=lRKA4fFqtGK4gdYK2dAFfFHy6ngEE9Qtu0SufGRzK7emO9U9NTy8aH2mi3Y478Digd
         WQy8QK5XstuTGhb9XzZn+LFNzFEj+6iYTfKkQmarmZZ35BvWgvQ8CKgKLKE+uP8NP9yw
         OMl0zMhcvreD4jw9Aejpc5pZBd8udv9+6rL4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=q1WWqBpqvk6sE9mDhVEW208xCGPCgpfi4tyWrP0iK5Ujc8R0js7tXzMQgK+7cLCYxH
         6wY+gw42wkpoQdtDpakeoPGyMtMtJ+L/XbTq6CGoo9FTEYnWd0HN2rjSW9PJhwJuKzhq
         maPD/J2MA1aE6AMw6itiKNPzGN88Ufe7Zvsh4=
Received: by 10.204.177.79 with SMTP id bh15mr7284630bkb.121.1287614595870;
        Wed, 20 Oct 2010 15:43:15 -0700 (PDT)
Received: from [192.168.1.13] (abvx10.neoplus.adsl.tpnet.pl [83.8.221.10])
        by mx.google.com with ESMTPS id t10sm610574bkj.16.2010.10.20.15.43.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 15:43:15 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159447>

The results of "Git User's Survey 2010" (without analysis or tabulating
'other, please specify' responses) are available at GitSurvey2010 page:

  https://git.wiki.kernel.org/index.php/GitSurvey2010


There are even beginnings of visualization (plots of histograms of
answers).  And there lies the question: how to visualize 'matrix'
type questions?  

Survs.com "Analyze" page provides one solution:

  https://www.survs.com/results/33Q0OZZE/MV653KSPI2
  http://tinyurl.com/GitSurvey2010Analysis

(check for example table for question 20).

I have created another at

  https://git.wiki.kernel.org/index.php/GitSurvey2010#20._In_your_opinion.2C_which_areas_in_Git_need_improvement.3F


What do you think about it?  How should we visualize results of those
kinds of questions on GitSurvey2010 wiki page?

-- 
Jakub Narebski
Poland
